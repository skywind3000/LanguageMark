use std::time::{SystemTime, UNIX_EPOCH};

const N:i32 = 13;

fn clock_realtime() -> i64 {
    let start = SystemTime::now();
    let since_the_epoch = start.duration_since(UNIX_EPOCH).expect("Time went backwards");
    return since_the_epoch.as_millis() as i64;
}

fn array_check(array: &[i32], row: i32) -> bool 
{
    if row == 0 {
        return true;
    }
    else {
        let x0 = array[row as usize];
        for y in 0..row {
            let x = array[y as usize];
            if x == x0 {
                return false;
            }
            else if x - x0 == row - y {
                return false;
            }
            else if x0 - x == row - y {
                return false;
            }
        }
        return true;
    }
}


fn queen() -> i32 {
    let mut array = [0;N as usize];
    let mut found = 0;
    let mut row = 0;
    let mut done = false;
    while ! done {
        if array_check(&array, row) {
            if row == N - 1 {
                found += 1;
            }   else {
                row += 1;
                array[row as usize] = 0;
                continue;
            }
        }
        array[row as usize] += 1;
        while array[row as usize] >= N {
            row -= 1;
            if row >= 0 {
                array[row as usize] += 1;
            }   else {
                done = true;
                break;
            }
        }
    }
    return found;
}

fn main() {
    queen();
    let ts = clock_realtime();
    let found = queen();
    let dt = clock_realtime() - ts;
    println!("found={} time={} ms", found, dt);
}



