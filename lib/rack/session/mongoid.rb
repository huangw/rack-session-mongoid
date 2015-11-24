require 'rack/session/mongoid/version'
require 'rack/session/abstract/id'
require 'awesome_print'

module Rack
  module Session
    # A mongoid document model for storing session data
    class RackSession
      include ::Mongoid::Document
      include ::Mongoid::Timestamps::Short
      field :sid, type: String
      field :data, type: Hash, default: {}

      index({ sid: 1 }, unique: true)
    end


    class Mongoid < Abstract::ID
      attr_reader :mutex, :pool

      DEFAULT_OPTIONS = Abstract::ID::DEFAULT_OPTIONS.merge drop: false
      def initialize(app, options={})
        super
        @mutex = Mutex.new
        RackSession.create_indexes
      end

      def generate_sid
        loop do
          sid = super
          break sid unless RackSession.where(sid: sid).asc(:_id).first
        end
      end

      def get_session(env, sid)
        with_lock(env) do
          unless sid and session = _get(sid)
            sid, session = generate_sid, {}
            _put sid, session
          end
          [sid, session]
        end
      end

      def set_session(env, session_id, new_session, options)
        with_lock(env) do
          _put session_id, new_session
          session_id
        end
      end

      def destroy_session(env, session_id, options)
        with_lock(env) do
          _delete(session_id)
          generate_sid unless options[:drop]
        end
      end

      def with_lock(env)
        @mutex.lock if env['rack.multithread']
        yield
      ensure
        @mutex.unlock if @mutex.locked?
      end

      private

      def _put(sid, session)
        model = _exists?(sid) || RackSession.new(sid: sid)
        model.data = session
        model.save!
        model
      end

      def _get(sid)
        if model = _exists?(sid)
          model.data
        end
      end

      def _delete(sid)
        RackSession.where(sid: sid).all.delete
      end

      def _exists?(sid)
        RackSession.where(sid: sid).asc(:_id).first
      end
    end
  end
end
