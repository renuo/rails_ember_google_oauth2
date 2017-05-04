import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model() {
    const headers = {};
    this.get('session').authorize('authorizer:google', (headerName, headerValue) => {
      headers[headerName] = headerValue;
    });
    return Ember.$.ajax('http://localhost:3000/toys', { headers });
  }
});
