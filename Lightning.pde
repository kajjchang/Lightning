Light[] lights;
boolean lastPressed;

void setup() {
  size(500, 500);
  lights = new Light[25];
  for (int i = 0; i < 25; i++) {
    lights[i] = new Light();
  }
  lastPressed = false;
}

void draw() {
  background(0);
  for (Light light : lights) {
    light.update();
  }
  lastPressed = mousePressed;
}

double[] equation(double x, double y, double t) {
  return new double[] {-Math.pow(y, 2) - Math.pow(t, 2) + t * x, y * t + x * y};
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
    angle = Math.atan2(center_x - this.x, center_y - this.y);
  }
  public void update() {
    x = Math.cos(angle) * radius + center_x;
    y = Math.sin(angle) * radius + center_y;
    angle += PI / 60;
    if (dist((float) x, (float) y, (float) target_x, (float) target_y) < 10) {
      // setTarget(Math.random() * width, Math.random() * height);
    }
    if (mousePressed && !lastPressed) {
      // setTarget(Math.random() * width, Math.random() * height);
    } else if (lastPressed && !mousePressed) {
      // setTarget(Math.random() * width, Math.random() * height);
    }
    if (history.size() == 100) {
      history.remove(0);
    }
    history.add(new Double[] {x, y});
    noStroke();
    fill(r, g, b);
    ellipse((float) x, (float) y, 15, 15);
    for (int i = 0; i < history.size() - 4; i += 3) {
      stroke(r, g, b, 255 * i / history.size());
      strokeWeight(5 * i / history.size());      
      Double[] historical_coords_1 = history.get(i);
      double historical_x_1 = historical_coords_1[0];
      double historical_y_1 = historical_coords_1[1];
      Double[] historical_coords_2 = history.get(i + 1);
      double historical_x_2 = historical_coords_2[0];
      double historical_y_2 = historical_coords_2[1];
      Double[] historical_coords_3 = history.get(i + 2);
      double historical_x_3 = historical_coords_3[0];
      double historical_y_3 = historical_coords_3[1];
      Double[] historical_coords_4 = history.get(i + 3);
      double historical_x_4 = historical_coords_4[0];
      double historical_y_4 = historical_coords_4[1];
      bezier((float) historical_x_1, (float) historical_y_1, (float) historical_x_2, (float) historical_y_2, (float) historical_x_3, (float) historical_y_3, (float) historical_x_4, (float) historical_y_4);
    }
  }
}
