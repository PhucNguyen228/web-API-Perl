package myWebSite::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use DBI;
use Data::Dumper;
use mojolicious::Plugin::TagHelpers;
use Mojolicious::Plugin::Database;

my $dbh = DBI->connect( "dbi:Pg:dbname=pagila-schema;host=localhost;port=5432",
    "postgres", "1234" );

# This action will render a template
sub welcome ($self) {
    my $sth = $dbh->prepare("SELECT * FROM customer");
    $sth->execute();

    # i want show the result in the browser
    my $customers = $sth->fetchall_arrayref( {} );
    $self->stash( customers => $customers );

    # show the result in json format
    # $self->stash(json =>{customers => $customers});

    # Render template "example/welcome.html.ep" with message
    $self->render(
        msg => 'Welcome to the Mojolicious real-time web framework!' );
}

1;
