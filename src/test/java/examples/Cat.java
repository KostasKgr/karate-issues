package examples;

public class Cat {
  public String groupId;
  public String externalId;
  public String internalId;
  public String name;
  public boolean active;
  public boolean failedToMap;

  public Cat(int id) {
    this.groupId = String.valueOf(id);
    this.externalId = String.valueOf(id);
    this.internalId = String.valueOf(id);
    this.name = String.valueOf(id);
    this.active = true;
    this.failedToMap = false;
  }
}
