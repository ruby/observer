# frozen_string_literal: true

require 'observer'
require 'test/unit'
require 'rbs/unit_test'

class ObserverInstanceTest < Test::Unit::TestCase
  include RBS::UnitTest::TypeAssertions

  library 'observer'
  testing "::Observable"

  class Ticker
    include Observable
  end

  class Observer
    def update(*args)
    end
  end

  def test_add_observer
    o = Observer.new
    assert_send_type '(untyped) -> void',
                     Ticker.new, :add_observer, o
    assert_send_type '(untyped, Symbol) -> void',
                     Ticker.new, :add_observer, o, :update
  end

  def test_changed
    assert_send_type '() -> void',
                     Ticker.new, :changed
    assert_send_type '(bool) -> void',
                     Ticker.new, :changed, false
  end

  def test_changed?
    assert_send_type '() -> bool',
                     Ticker.new, :changed?
  end

  def test_count_observers
    assert_send_type '() -> Integer',
                     Ticker.new, :count_observers
  end

  def test_delete_observer
    assert_send_type '(untyped) -> void',
                     Ticker.new, :delete_observer, Observer.new
  end

  def test_delete_observers
    assert_send_type '() -> void',
                     Ticker.new, :delete_observers
  end

  def test_notify_observers
    assert_send_type '() -> void',
                     Ticker.new, :notify_observers
    assert_send_type '(untyped) -> void',
                     Ticker.new, :notify_observers, 1
    assert_send_type '(untyped, untyped) -> void',
                     Ticker.new, :notify_observers, 1, 2
  end
end
