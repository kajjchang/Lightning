Light[] lights;

void setup() {
  size(500, 500);
  lights = new Light[25];
  for (int i = 0; i < 25; i++) {
    lights[i] = new Light();
  }
}

void draw() {
  background(0);
  for (Light light : lights) {
    light.update();
  }
}

double[] equation(double x, double y, double t) {
  return new double[] {-Math.pow(y, 2) - Math.pow(t, 2) + t * x, y * t + x * y};
}

class Light {
  double x, y;
  int r, g, b;
  double target_x, target_y;
  color col;
  ArrayList<Double[]> history;
  
  public Light() {
    r = (int) (Math.random() * 256);
    g = (int) (Math.random() * 256);
    b = (int) (Math.random() * 256);
    x = Math.random() * width;
    y = Math.random() * height;
    target_x = Math.random() * width;
    target_y = Math.random() * height;
    history = new ArrayList<Double[]>();
  }
  public void update() {
    double filtered_target_x, filtered_target_y;
    if (mousePressed) {
      filtered_target_x = mouseX;
      filtered_target_y = mouseY;
    } else {
      filtered_target_x = target_x;
      filtered_target_y = target_y;
    }
    double dist_x = filtered_target_x - x;
    double dist_y = filtered_target_y - y;
    double angle = Math.atan2(dist_y, dist_x);
    x += Math.cos(angle) * 5;
    y += Math.sin(angle) * 5;
    if (dist((float) x, (float) y, (float) target_x, (float) target_y) < 5) {
      target_x = Math.random() * width;
      target_y = Math.random() * height;
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
