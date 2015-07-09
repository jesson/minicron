'use strict';

(function() {
  Minicron.JobsRoute = Ember.Route.extend({
    model: function() {
      return this.store.find('job');
    },
    afterModel: Minicron.onViewLoad
  });

  Minicron.JobsIndexRoute = Ember.Route.extend({
    model: function() {
      return this.store.all('job');
    },
    setupController: function(controller, model) {
      controller.set('model', model);
    },
    afterModel: Minicron.onViewLoad
  });

  Minicron.JobRoute = Ember.Route.extend({
    model: function(params) {
      return this.store.find('job', params.id);
    },
    afterModel: Minicron.onViewLoad
  });

  Minicron.JobIndexRoute = Ember.Route.extend({
    model: function() {
      return this.modelFor('job');
    },
    afterModel: Minicron.onViewLoad
  });

  Minicron.JobsNewRoute = Ember.Route.extend({
    model: function() {
      return Ember.RSVP.hash({ hosts: this.store.find('host'), alert_options_subgroups: this.store.find('alert_options_subgroup') });
    },
    setupController: function(controller, model) {
      controller.set('model', model);
    },
    afterModel: Minicron.onViewLoad
  });

  Minicron.JobEditRoute = Ember.Route.extend({
    model: function() {
      return Ember.RSVP.hash({ job: this.modelFor('job'), alert_options_subgroups: this.store.find('alert_options_subgroup') });
    },
    setupController: function(controller, model) {
      controller.set('model', model.job);
      controller.set('alert_options_subgroups', model.alert_options_subgroups);
    },
    afterModel: Minicron.onViewLoad
  });
})();
