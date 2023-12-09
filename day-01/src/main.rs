use std::fs::read_to_string;

fn main() {
    println!("{}", part1());
    println!("{}", part2());
}

fn part2() -> i32 {
    let mut sum = 0;
    for line in read_to_string("input").unwrap().lines() {
        let first = first_digit2(line);
        let last = last_digit2(line);
        let mut a_string = String::from("");
        a_string.push(first);
        a_string.push(last);
        let c = a_string.parse::<i32>().unwrap();
        sum += c;
    }
    return sum;
}

fn last_digit2(line: &str) -> char {
    for j in 0..(line.len()) {
        let i = line.len() - j - 1;

        if line[i..].starts_with("one") {
            return '1';
        }
        if line[i..].starts_with("two") {
            return '2';
        }
        if line[i..].starts_with("three") {
            return '3';
        }
        if line[i..].starts_with("four") {
            return '4';
        }
        if line[i..].starts_with("five") {
            return '5';
        }
        if line[i..].starts_with("six") {
            return '6';
        }
        if line[i..].starts_with("seven") {
            return '7';
        }
        if line[i..].starts_with("eight") {
            return '8';
        }
        if line[i..].starts_with("nine") {
            return '9';
        }
        let c = line.chars().nth(i).unwrap();
        if c.to_digit(10).is_some() {
            return c;
        }
    }
    return ' ';
}

fn first_digit2(line: &str) -> char {
    for i in 0..line.len() {
        if line[i..].starts_with("one") {
            return '1';
        }
        if line[i..].starts_with("two") {
            return '2';
        }
        if line[i..].starts_with("three") {
            return '3';
        }
        if line[i..].starts_with("four") {
            return '4';
        }
        if line[i..].starts_with("five") {
            return '5';
        }
        if line[i..].starts_with("six") {
            return '6';
        }
        if line[i..].starts_with("seven") {
            return '7';
        }
        if line[i..].starts_with("eight") {
            return '8';
        }
        if line[i..].starts_with("nine") {
            return '9';
        }
        let c = line.chars().nth(i).unwrap();
        if c.to_digit(10).is_some() {
            return c;
        }
    }

    return ' ';
}

fn word_digit() -> Option<char> {
    return None;
}

fn part1() -> i32 {
    let mut sum = 0;
    for line in read_to_string("input").unwrap().lines() {
        let first = first_digit(line.chars());
        let last = last_digit(line.chars());
        let mut a_string = String::from("");
        a_string.push(first);
        a_string.push(last);
        let c = a_string.parse::<i32>().unwrap();
        sum += c;
    }
    return sum;
}

fn last_digit(chars: std::str::Chars) -> char {
    for c in chars.rev() {
        let d = c.to_digit(10);
        if d.is_some() {
            return c;
        }
    }
    return ' ';
}

fn first_digit(chars: std::str::Chars) -> char {
    for c in chars {
        let d = c.to_digit(10);
        if d.is_some() {
            return c;
        }
    }
    return ' ';
}
