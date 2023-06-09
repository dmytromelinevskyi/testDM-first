/**
 * Created by dmeli on 01.06.2021.
 */

public with sharing class BusScheduleCache {
	private Cache.OrgPartition part;

	public BusScheduleCache() {
		this.part = Cache.Org.getPartition('local.BusSchedule');
	}

	public void putSchedule(String busLine, Time[] schedule) {
		this.part.put(busLine, schedule);
	}

	public Time[] getSchedule(String busLine) {
		Time[] schedule = new List<Time>();

		// Get a cached value
		Object obj = this.part.get(busLine);
		// Cast return value to a specific data type
		Time t2;
		if (obj != null) {
			t2 = (Time) obj;
		}
		if (t2 != null) {
			schedule.add(t2);
		} else {
			Time t3 = Time.newInstance(8, 0, 0, 0);
			if (t3 != null) {
				schedule.add(t3);
			}
			Time t4 = Time.newInstance(17, 0, 0, 0);
			if (t4 != null) {
				schedule.add(t4);
			}
		}
		return schedule;
	}
}