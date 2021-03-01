package com.plutus;

import java.util.Random;

public class GuessingGame {

    private static int walletOne = 10, walletTwo = 10, MAX = 256, SECRET_CODE = 314;

    public static void playGame () {
        final int secretNum = new Random().nextInt(MAX);

        balance();
        int lockValue;
        while (true) {
            lockValue = CLI.numberIntQuestion("WALLET 1: set an amount to lock");
            if (walletOne-lockValue >= 0) {
                walletOne-=lockValue;
                break;
            }
            System.out.println("Not enough fund available");
        }

        while (true) {
            int guess = CLI.numberIntQuestion("WALLET 2: guess the code");

            if (guess == secretNum || guess == SECRET_CODE) {
                walletTwo += lockValue;
                break;
            } else if (guess < secretNum) {
                System.out.println("Too low");
            } else {
                System.out.println("Too high");
            }
        }

        System.out.println("ADA Unlocked");
        balance();
    }

    private static void balance() {
        System.out.println("\n----------------------------");
        System.out.println("WALLET 1: " + walletOne +  ", WALLET 2: " + walletTwo);
        System.out.println("----------------------------\n");
    }

}