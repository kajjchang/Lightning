Light[] lights;

void setup() {
  size(500, 500);
  lights = new Light[25];
  for (int i = 0; i < lights.length; i++) {
    lights[i] = new Light();
  }
}

void draw() {
  background(0);
  for (Light light : lights) {
    light.update();
  }
}

class Light {
  double x, y;
  int r, g, b;
  double target_x, target_y, center_x, center_y, radius, angle;
  color col;
  ArrayList<Double[]> history;
  
  public Light() {
    r = (int) (Math.random() * 256);
    g = (int) (Math.random() * 256);
    b = (int) (Math.random() * 256);
    x = Math.random() * width;
    y = Math.random() * height;
    setTarget(Math.random() * width, Math.random() * height);
    history = new ArrayList<Double[]>();
  }
  public void setTarget(double x, double y) {
    target_x = x;
    target_y = y;
    center_x = (target_x + this.x) / 2;
    center_y = (target_y + this.y) / 2;
    radius = dist((float) center_x, (float) center_y, (float) this.x, (float) this.y);
    angle = Math.atan((center_y - this.y) / (center_x - this.x));
    if ((int) (Math.cos(angle) * radius + center_x) == (int) target_x && (int) (Math.sin(angle) * radius + center_y) == (int) target_y) {
      angle += PI;
    }
  }
  public void update() {
    x = Math.cos(angle) * radius + center_x;
    y = Math.sin(angle) * radius + center_y;
    angle += PI / 60;
    if (dist((float) target_x, (float) target_y, (float) x, (float) y) <= 10) {
      setTarget(Math.random() * width, Math.random() * height);
    }
    if (history.size() == 100) {
      history.remove(0);
    }
    history.add(new Double[] {x, y});
    noStroke();
    fill(r, g, b);
    ellipse((float) x, (float) y, 15, 15);
    for (int i = 0; i < history.size() - 1; i ++) {
      stroke(r, g, b, 255 * i / history.size());
      strokeWeight(5 * i / history.size());   
      line(doubletofloat(history.get(i)[0]), doubletofloat(history.get(i)[1]), doubletofloat(history.get(i + 1)[0]), doubletofloat(history.get(i + 1)[1])); 
    }
  }
}

float doubletofloat(double d) {
  return (float) d;
}
