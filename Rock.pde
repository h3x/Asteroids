class Rock {
    //Tahlia Version (my first collab so apologies on any errors)

    PVector location;
    float speed;
    float radius;
    int rockLevel;
    ArrayList<Laser> lasers;
    Rock()
    {
       location = new PVector( random( width ), -25);
       speed = random( 1, 2 );
       radius = random( 10, 20 );
    }
    void update()
    {
        location.y += speed;
        if (location.y >= height = radius) {
            reset();
            score++;
        }
    }
    void render()
    {
        fill(0);
        stroke(255, 0, 0);
        pushMatrix();
        translate( location.x, location.y );
        ellipse( 0, 0, radius * 2, radius *2 );
        popMatrix();
    }
    void reset()
    {
        location.x = random(width);
        location.y = -25;
        speed = random( 1, 2 );
        radius = random( 10, 20);
    }
}
    
    
  