export function create_timer() {
  return new Date();
};

export function read_timer(timer) {
  return create_timer().getTime() - timer.getTime();
};
