fn main() {
    let input = include_str!("../input/1.txt");
    println!("Part 1: {}", q1p1(input));
    println!("Part 2: {}", q1p2(input));
}

fn q1p1(input: &str) -> u32 {
    let mut sum = 0;
    for line in input.lines() {
        let first = line.chars().find(|&x| x.is_digit(10)).unwrap();
        let last = line.chars().rev().find(|&x| x.is_digit(10)).unwrap();
        let first = first.to_digit(10).unwrap();
        let last = last.to_digit(10).unwrap();
        let number = first * 10 + last;
        sum += number;
    }
    sum
}

fn q1p2(input: &str) -> i32 {
    let english_numbers = [
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    ];
    let mut sum = 0;
    for line in input.lines() {
        let first_number = {
            let mut min_index = i32::MAX;
            let mut number = 0i32;
            for (i, &english_number) in english_numbers.iter().enumerate() {
                if let Some(index) = line.find(english_number) {
                    let index = index as i32;
                    if index < min_index {
                        min_index = index;
                        number = i as i32;
                    }
                }
            }
            let (first_digit_index, first_digit) =
                line.char_indices().find(|&(_, x)| x.is_digit(10)).unwrap();
            if (first_digit_index as i32) < min_index || min_index == i32::MAX {
                number = first_digit.to_digit(10).unwrap() as i32;
            } else {
                number += 1;
            }
            number
        };
        let last_number = {
            let mut max_index = i32::MIN;
            let mut number = 0i32;
            for (i, &english_number) in english_numbers.iter().enumerate() {
                if let Some(index) = line.rfind(english_number) {
                    let index = index + english_number.len() - 1;
                    if (index as i32) > max_index {
                        max_index = index as i32;
                        number = i as i32;
                    }
                }
            }
            let (last_digit_index, last_digit) = line
                .char_indices()
                .rev()
                .find(|&(_, x)| x.is_digit(10))
                .unwrap();
            // dbg!(last_digit, last_digit_index, max_index);
            if last_digit_index as i32 > max_index || max_index == i32::MIN {
                number = last_digit.to_digit(10).unwrap() as i32;
            } else {
                number += 1;
            }
            number
        };
        let number = first_number * 10 + last_number;
        sum += number;
        println!("{}: {}", line, number)
    }
    sum
}
