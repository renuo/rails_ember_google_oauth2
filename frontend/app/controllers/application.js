import Ember from 'ember';
import config from '../config/environment';

export default Ember.Controller.extend({
  session: Ember.inject.service(),
  config: config.torii.providers['google-oauth2'],
  actions: {
    logout() {
      this.get('session').invalidate();
    }
  }
});
