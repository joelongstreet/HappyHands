(function() {
  var Listener;

  exports.HappyHands = (function() {

    function HappyHands(window, options) {
      var _this = this;
      this.checks = 0;
      if (options) {
        this.accuracy = options.accuracy || 5;
        this.poll_speed = options.poll_speed || 50;
      } else {
        this.accuracy = 5;
        this.poll_speed = 50;
      }
      this.listeners = [];
      this.position = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      window.ondeviceorientation = function(e) {
        _this.position[0] = e.alpha;
        _this.position[1] = e.beta;
        return _this.position[2] = e.gamma;
      };
      window.ondevicemotion = function(e) {
        _this.position[3] = e.acceleration.x;
        _this.position[4] = e.acceleration.y;
        _this.position[5] = e.acceleration.z;
        _this.position[6] = e.accelerationIncludingGravity.x;
        _this.position[7] = e.accelerationIncludingGravity.y;
        return _this.position[8] = e.accelerationIncludingGravity.z;
      };
      setInterval((function() {
        return _this.check_listeners();
      }), this.poll_speed);
    }

    HappyHands.prototype.on = function(records, callback, options) {
      var listener;
      if (!options) options = {};
      listener = new Listener(records, this, callback, options);
      this.listeners.push(listener);
      return listener;
    };

    HappyHands.prototype.check_listeners = function() {
      var listener, _i, _len, _ref, _results;
      this.checks++;
      _ref = this.listeners;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        listener = _ref[_i];
        _results.push(listener.check_status());
      }
      return _results;
    };

    return HappyHands;

  })();

  Listener = (function() {

    function Listener(records, parent, callback, options) {
      this.records = records;
      this.parent = parent;
      this.callback = callback;
      if (options) {
        this.options = options;
      } else {
        this.options = {};
      }
      if (this.options.accuracy) {
        this.accuracy = this.options.accuracy;
      } else {
        this.accuracy = this.parent.accuracy;
      }
      this.complete = false;
      this.current_pos = 0;
      this.time = 0;
      this.passes = 0;
    }

    Listener.prototype.check_status = function() {
      var point, start_time, _i, _len, _ref;
      this.passes = 0;
      start_time = new Date().getTime();
      _ref = this.records[this.current_pos];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        point = _ref[_i];
        if (Math.abs(point - this.parent.position[_i]) < this.accuracy) {
          this.passes++;
          if (this.passes === 9) this.current_pos++;
        }
      }
      if (this.passes === 9 && (this.current_pos === this.records.length)) {
        this.time = new Date().getTime() - start_time;
        this.current_pos = 0;
        this.callback();
        if (this.options.kill_on_complete) return this.remove_from_parent();
      }
    };

    Listener.prototype.remove_from_parent = function() {
      var index;
      index = this.parent.listeners.indexOf(this);
      return this.parent.listeners.splice(index, 1);
    };

    return Listener;

  })();

}).call(this);
