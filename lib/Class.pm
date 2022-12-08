package Class;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('CustomController#displayLogin'); 
  $r->post('/welcome')->to('CustomController#welcome');
  $r->get('/login')->to('CustomController#logout');

  my $authorized = $r->under('/')->to('CustomController#alreadyLoggedIn');
}

1;
__DATA__