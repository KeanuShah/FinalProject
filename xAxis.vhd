
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity xAxis is
    port(clk, rst: in std_logic;
         addr: in std_logic_vector(9 downto 0);
         dout: out std_logic_vector(7 downto 0));
end xAxis;

architecture Behavioral of xAxis is

    type mem is array (0 to 714) of std_logic_vector(7 downto 0);
    signal XAxis: mem := (
        0 => "00000000",
        1 => "00000000",
        2 => "00000000",
        3 => "00000000",
        4 => "00000000",
        5 => "00000000",
        6 => "00000000",
        7 => "00000000",
        8 => "01001000",
        9 => "11111111",
        10 => "11011011",
        11 => "00100100",
        12 => "00000000",
        13 => "00000000",
        14 => "00000000",
        15 => "00000000",
        16 => "00000000",
        17 => "00000000",
        18 => "00000000",
        19 => "00000000",
        20 => "00000000",
        21 => "00000000",
        22 => "00000000",
        23 => "00000000",
        24 => "00000000",
        25 => "00000000",
        26 => "00000000",
        27 => "00000000",
        28 => "00000000",
        29 => "00000000",
        30 => "00000000",
        31 => "00000000",
        32 => "00000000",
        33 => "00000000",
        34 => "00000000",
        35 => "00000000",
        36 => "01001000",
        37 => "11011011",
        38 => "01101101",
        39 => "00000000",
        40 => "00000000",
        41 => "00000000",
        42 => "00000000",
        43 => "00000000",
        44 => "00000000",
        45 => "00000000",
        46 => "00000000",
        47 => "00000000",
        48 => "00000000",
        49 => "00000000",
        50 => "00000000",
        51 => "00000000",
        52 => "00000000",
        53 => "00000000",
        54 => "00000000",
        55 => "00000000",
        56 => "00000000",
        57 => "00000000",
        58 => "00000000",
        59 => "00000000",
        60 => "01001000",
        61 => "11111111",
        62 => "10010001",
        63 => "00000000",
        64 => "00000000",
        65 => "10110110",
        66 => "11111111",
        67 => "11111111",
        68 => "11111111",
        69 => "11111111",
        70 => "11111111",
        71 => "01101101",
        72 => "00000000",
        73 => "01001000",
        74 => "11111111",
        75 => "11011011",
        76 => "00100100",
        77 => "00000000",
        78 => "00000000",
        79 => "00000000",
        80 => "00000000",
        81 => "00000000",
        82 => "00000000",
        83 => "00000000",
        84 => "00000000",
        85 => "00000000",
        86 => "00000000",
        87 => "00000000",
        88 => "00000000",
        89 => "00000000",
        90 => "00000000",
        91 => "00000000",
        92 => "00000000",
        93 => "00000000",
        94 => "00000000",
        95 => "00000000",
        96 => "00000000",
        97 => "00000000",
        98 => "00000000",
        99 => "00000000",
        100 => "01001000",
        101 => "11111111",
        102 => "11011010",
        103 => "00000000",
        104 => "00000000",
        105 => "00000000",
        106 => "00000000",
        107 => "00000000",
        108 => "00000000",
        109 => "00000000",
        110 => "00000000",
        111 => "00000000",
        112 => "00000000",
        113 => "00000000",
        114 => "00000000",
        115 => "00000000",
        116 => "00000000",
        117 => "00000000",
        118 => "00000000",
        119 => "00000000",
        120 => "00000000",
        121 => "00000000",
        122 => "00000000",
        123 => "00000000",
        124 => "00000000",
        125 => "00000000",
        126 => "10110110",
        127 => "11111111",
        128 => "01101101",
        129 => "00000000",
        130 => "00000000",
        131 => "00000000",
        132 => "10110110",
        133 => "11111111",
        134 => "01001000",
        135 => "00000000",
        136 => "00000000",
        137 => "00000000",
        138 => "00000000",
        139 => "00000000",
        140 => "00000000",
        141 => "00000000",
        142 => "00000000",
        143 => "00000000",
        144 => "00000000",
        145 => "00000000",
        146 => "00000000",
        147 => "00000000",
        148 => "00000000",
        149 => "00000000",
        150 => "00000000",
        151 => "00000000",
        152 => "00000000",
        153 => "00000000",
        154 => "00000000",
        155 => "00000000",
        156 => "00000000",
        157 => "00000000",
        158 => "00000000",
        159 => "00000000",
        160 => "00000000",
        161 => "00000000",
        162 => "00000000",
        163 => "00000000",
        164 => "00000000",
        165 => "11011010",
        166 => "11011011",
        167 => "00100100",
        168 => "00000000",
        169 => "00000000",
        170 => "00000000",
        171 => "00000000",
        172 => "00000000",
        173 => "00000000",
        174 => "00000000",
        175 => "00000000",
        176 => "00000000",
        177 => "00000000",
        178 => "00000000",
        179 => "00000000",
        180 => "00000000",
        181 => "00000000",
        182 => "00000000",
        183 => "00000000",
        184 => "00000000",
        185 => "00000000",
        186 => "00000000",
        187 => "00000000",
        188 => "00000000",
        189 => "00000000",
        190 => "00000000",
        191 => "00000000",
        192 => "11011010",
        193 => "11011011",
        194 => "00100100",
        195 => "00000000",
        196 => "00000000",
        197 => "10110110",
        198 => "11111111",
        199 => "01001000",
        200 => "00000000",
        201 => "00000000",
        202 => "10110110",
        203 => "11111111",
        204 => "11111111",
        205 => "11011011",
        206 => "00100100",
        207 => "00000000",
        208 => "10010001",
        209 => "11111111",
        210 => "11111111",
        211 => "11111111",
        212 => "11111111",
        213 => "11111111",
        214 => "10010001",
        215 => "00000000",
        216 => "10010001",
        217 => "11111111",
        218 => "11111111",
        219 => "11111111",
        220 => "01001000",
        221 => "00000000",
        222 => "00000000",
        223 => "00000000",
        224 => "00000000",
        225 => "00000000",
        226 => "00000000",
        227 => "00000000",
        228 => "00000000",
        229 => "01001000",
        230 => "11111111",
        231 => "10010001",
        232 => "00000000",
        233 => "00000000",
        234 => "00000000",
        235 => "00100100",
        236 => "11011011",
        237 => "11111111",
        238 => "11111111",
        239 => "11011011",
        240 => "00100100",
        241 => "00000000",
        242 => "00100100",
        243 => "11011011",
        244 => "11111111",
        245 => "11111111",
        246 => "10110110",
        247 => "00000000",
        248 => "00000000",
        249 => "01001000",
        250 => "11111111",
        251 => "11111111",
        252 => "11111111",
        253 => "10110110",
        254 => "00000000",
        255 => "00000000",
        256 => "00000000",
        257 => "01101101",
        258 => "11111111",
        259 => "10010001",
        260 => "00000000",
        261 => "00000000",
        262 => "10110110",
        263 => "11111111",
        264 => "01001000",
        265 => "00000000",
        266 => "00000000",
        267 => "00000000",
        268 => "00100100",
        269 => "11011011",
        270 => "11011011",
        271 => "00100100",
        272 => "00000000",
        273 => "10010001",
        274 => "11111111",
        275 => "10010001",
        276 => "11111111",
        277 => "10110110",
        278 => "11111111",
        279 => "10110110",
        280 => "01101101",
        281 => "11111111",
        282 => "01101101",
        283 => "00000000",
        284 => "11011010",
        285 => "11011011",
        286 => "00100100",
        287 => "00000000",
        288 => "00000000",
        289 => "00000000",
        290 => "00000000",
        291 => "00000000",
        292 => "00000000",
        293 => "00000000",
        294 => "10010001",
        295 => "11111111",
        296 => "01101101",
        297 => "00000000",
        298 => "00000000",
        299 => "00000000",
        300 => "10110110",
        301 => "11111111",
        302 => "01001000",
        303 => "00000000",
        304 => "00000000",
        305 => "00000000",
        306 => "00000000",
        307 => "11011010",
        308 => "11011010",
        309 => "00000000",
        310 => "01101101",
        311 => "11111111",
        312 => "10010001",
        313 => "01001000",
        314 => "11111111",
        315 => "11011010",
        316 => "00000000",
        317 => "00000000",
        318 => "00000000",
        319 => "00000000",
        320 => "00000000",
        321 => "00000000",
        322 => "00100100",
        323 => "11011011",
        324 => "10110110",
        325 => "00000000",
        326 => "00000000",
        327 => "10110110",
        328 => "11111111",
        329 => "01001000",
        330 => "00000000",
        331 => "00000000",
        332 => "00000000",
        333 => "00100100",
        334 => "11011011",
        335 => "11011011",
        336 => "00100100",
        337 => "00000000",
        338 => "10010001",
        339 => "11111111",
        340 => "01101101",
        341 => "11111111",
        342 => "10010001",
        343 => "11111111",
        344 => "11011010",
        345 => "10110110",
        346 => "11111111",
        347 => "11111111",
        348 => "11111111",
        349 => "11111111",
        350 => "11011011",
        351 => "00100100",
        352 => "00000000",
        353 => "00000000",
        354 => "00000000",
        355 => "00000000",
        356 => "00000000",
        357 => "00000000",
        358 => "00000000",
        359 => "10010001",
        360 => "11111111",
        361 => "01001000",
        362 => "00000000",
        363 => "00000000",
        364 => "00000000",
        365 => "10010001",
        366 => "11111111",
        367 => "11111111",
        368 => "11011010",
        369 => "00000000",
        370 => "00000000",
        371 => "01001000",
        372 => "11111111",
        373 => "11111111",
        374 => "11111111",
        375 => "11111111",
        376 => "11111111",
        377 => "10010001",
        378 => "10010001",
        379 => "11111111",
        380 => "01101101",
        381 => "00000000",
        382 => "00000000",
        383 => "00000000",
        384 => "00000000",
        385 => "00000000",
        386 => "00000000",
        387 => "00100100",
        388 => "11011011",
        389 => "10110110",
        390 => "00000000",
        391 => "00000000",
        392 => "10110110",
        393 => "11111111",
        394 => "01001000",
        395 => "00000000",
        396 => "00000000",
        397 => "00000000",
        398 => "00100100",
        399 => "11011011",
        400 => "11011011",
        401 => "00100100",
        402 => "00000000",
        403 => "10010001",
        404 => "11111111",
        405 => "01101101",
        406 => "11111111",
        407 => "10010001",
        408 => "11111111",
        409 => "11011010",
        410 => "10110110",
        411 => "11111111",
        412 => "01001000",
        413 => "00000000",
        414 => "00000000",
        415 => "00000000",
        416 => "00000000",
        417 => "00000000",
        418 => "00000000",
        419 => "00000000",
        420 => "00000000",
        421 => "00000000",
        422 => "00000000",
        423 => "00000000",
        424 => "10010001",
        425 => "11111111",
        426 => "01101101",
        427 => "00000000",
        428 => "00000000",
        429 => "00000000",
        430 => "00000000",
        431 => "00000000",
        432 => "11011010",
        433 => "11111111",
        434 => "11111111",
        435 => "01101101",
        436 => "01001000",
        437 => "11111111",
        438 => "10110110",
        439 => "00000000",
        440 => "00000000",
        441 => "00000000",
        442 => "00000000",
        443 => "10010001",
        444 => "11111111",
        445 => "01101101",
        446 => "00000000",
        447 => "00000000",
        448 => "00000000",
        449 => "00000000",
        450 => "00000000",
        451 => "00000000",
        452 => "00100100",
        453 => "11011011",
        454 => "10110110",
        455 => "00000000",
        456 => "00000000",
        457 => "10110110",
        458 => "11111111",
        459 => "01001000",
        460 => "00000000",
        461 => "00000000",
        462 => "00000000",
        463 => "00100100",
        464 => "11011011",
        465 => "11011011",
        466 => "00100100",
        467 => "00000000",
        468 => "10010001",
        469 => "11111111",
        470 => "01101101",
        471 => "11111111",
        472 => "10010001",
        473 => "11111111",
        474 => "11011010",
        475 => "10010001",
        476 => "11111111",
        477 => "10110110",
        478 => "00000000",
        479 => "00000000",
        480 => "00000000",
        481 => "00000000",
        482 => "00000000",
        483 => "00000000",
        484 => "00000000",
        485 => "00000000",
        486 => "00000000",
        487 => "00000000",
        488 => "00000000",
        489 => "01001000",
        490 => "11111111",
        491 => "10110110",
        492 => "00000000",
        493 => "00000000",
        494 => "00000000",
        495 => "00000000",
        496 => "00000000",
        497 => "00000000",
        498 => "10010001",
        499 => "11111111",
        500 => "10010001",
        501 => "00100100",
        502 => "11011011",
        503 => "11111111",
        504 => "01001000",
        505 => "00000000",
        506 => "00000000",
        507 => "00000000",
        508 => "01001000",
        509 => "11111111",
        510 => "11011010",
        511 => "00000000",
        512 => "00000000",
        513 => "00000000",
        514 => "00000000",
        515 => "00000000",
        516 => "00000000",
        517 => "01101101",
        518 => "11111111",
        519 => "01101101",
        520 => "00000000",
        521 => "00000000",
        522 => "10110110",
        523 => "11111111",
        524 => "01001000",
        525 => "00000000",
        526 => "00000000",
        527 => "11011010",
        528 => "11111111",
        529 => "11111111",
        530 => "11111111",
        531 => "11111111",
        532 => "10110110",
        533 => "10010001",
        534 => "11111111",
        535 => "01101101",
        536 => "11111111",
        537 => "10010001",
        538 => "11111111",
        539 => "11011010",
        540 => "00000000",
        541 => "10110110",
        542 => "11111111",
        543 => "11111111",
        544 => "11111111",
        545 => "11011010",
        546 => "00000000",
        547 => "00000000",
        548 => "00000000",
        549 => "00000000",
        550 => "00000000",
        551 => "00000000",
        552 => "00000000",
        553 => "00000000",
        554 => "00000000",
        555 => "11011010",
        556 => "11111111",
        557 => "01001000",
        558 => "00000000",
        559 => "00000000",
        560 => "10110110",
        561 => "11111111",
        562 => "11111111",
        563 => "11111111",
        564 => "11011010",
        565 => "00000000",
        566 => "00000000",
        567 => "01001000",
        568 => "11111111",
        569 => "11111111",
        570 => "11111111",
        571 => "11111111",
        572 => "01101101",
        573 => "00000000",
        574 => "01101101",
        575 => "11111111",
        576 => "11111111",
        577 => "11111111",
        578 => "10110110",
        579 => "00000000",
        580 => "00000000",
        581 => "00000000",
        582 => "11011010",
        583 => "11011011",
        584 => "00100100",
        585 => "00000000",
        586 => "00000000",
        587 => "00000000",
        588 => "00000000",
        589 => "00000000",
        590 => "00000000",
        591 => "00000000",
        592 => "00000000",
        593 => "00000000",
        594 => "00000000",
        595 => "00000000",
        596 => "00000000",
        597 => "00000000",
        598 => "00000000",
        599 => "00000000",
        600 => "00000000",
        601 => "00000000",
        602 => "00000000",
        603 => "00000000",
        604 => "00000000",
        605 => "00000000",
        606 => "00000000",
        607 => "00000000",
        608 => "00000000",
        609 => "00000000",
        610 => "00000000",
        611 => "00000000",
        612 => "00000000",
        613 => "00000000",
        614 => "00000000",
        615 => "00000000",
        616 => "00000000",
        617 => "00000000",
        618 => "00000000",
        619 => "00000000",
        620 => "01001000",
        621 => "11111111",
        622 => "11011010",
        623 => "00000000",
        624 => "00000000",
        625 => "00000000",
        626 => "00000000",
        627 => "00000000",
        628 => "00000000",
        629 => "00000000",
        630 => "00000000",
        631 => "00000000",
        632 => "00000000",
        633 => "00000000",
        634 => "00000000",
        635 => "00000000",
        636 => "00000000",
        637 => "00000000",
        638 => "00000000",
        639 => "00000000",
        640 => "00000000",
        641 => "00000000",
        642 => "00000000",
        643 => "00000000",
        644 => "00000000",
        645 => "00000000",
        646 => "10010001",
        647 => "11111111",
        648 => "01101101",
        649 => "00000000",
        650 => "00000000",
        651 => "00000000",
        652 => "00000000",
        653 => "00000000",
        654 => "00000000",
        655 => "00000000",
        656 => "00000000",
        657 => "00000000",
        658 => "00000000",
        659 => "00000000",
        660 => "00000000",
        661 => "00000000",
        662 => "00000000",
        663 => "00000000",
        664 => "00000000",
        665 => "00000000",
        666 => "00000000",
        667 => "00000000",
        668 => "00000000",
        669 => "00000000",
        670 => "00000000",
        671 => "00000000",
        672 => "00000000",
        673 => "00000000",
        674 => "00000000",
        675 => "00000000",
        676 => "00000000",
        677 => "00000000",
        678 => "00000000",
        679 => "00000000",
        680 => "00000000",
        681 => "00000000",
        682 => "00000000",
        683 => "00000000",
        684 => "00000000",
        685 => "00000000",
        686 => "01101101",
        687 => "11111111",
        688 => "01101101",
        689 => "00000000",
        690 => "00000000",
        691 => "00000000",
        692 => "00000000",
        693 => "00000000",
        694 => "00000000",
        695 => "00000000",
        696 => "00000000",
        697 => "00000000",
        698 => "00000000",
        699 => "00000000",
        700 => "00000000",
        701 => "00000000",
        702 => "00000000",
        703 => "00000000",
        704 => "00000000",
        705 => "00000000",
        706 => "00000000",
        707 => "00000000",
        708 => "00000000",
        709 => "00000000",
        710 => "01001000",
        711 => "11111111",
        712 => "10010001",
        713 => "00000000",
        714 => "00000000");

begin

    process(clk)
    begin
    
        if rising_edge(clk) then
            if rst = '1' then
                XAxis <= (others => (others => '0'));
            else
                dout <= XAxis(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;


end Behavioral;
