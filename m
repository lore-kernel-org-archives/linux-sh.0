From: Martin Townsend <mtownsend1973@gmail.com>
Date: Thu, 05 May 2016 10:36:18 +0000
Subject: SH7760 IRL Interrupt level 15 not working for SMSC 91C111
Message-Id: <CABatt_yELUqBkEC+RDz0u=r=BR1XbjDbj5bC9ccJGtJyjX7Lqw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I'm trying to get the interrupt working for the LAN91C111 on our
board.  It has a SH7760 core and the documentation says the interrupt
is using IRL code of 15 (the highest priority).  The SH7760 HW manual
states that this is an INTEVT code of H'200.  In my board support
source file I'm using the following:

/*
 * SMSC LAN91C111 Ethernet Platform Data
 */
static struct smc91x_platdata smc91x_info = {
    .flags = SMC91X_USE_16BIT | IORESOURCE_IRQ_LOWLEVEL,
};

static struct resource smc91x_resources[] = {
    DEFINE_RES_MEM_NAMED(HICONECT_ETHERNET_BASE, HICONECT_ETHERNET_IOLEN,
                 "smc91x-memory"),
    DEFINE_RES_IRQ_NAMED(evt2irq(0x200), "smc91x-irq"),
};

static struct platform_device smc91x_device = {
    .name        = "smc91x",
    .id        = -1,
    .num_resources    = ARRAY_SIZE(smc91x_resources),
    .resource    = smc91x_resources,

    .dev = {
        .platform_data    = &smc91x_info,
    },
};

I've enabled the SMSC91x Ethernet Driver but it always fails to request the IRQ.
I see that the evt2irq(0x200) gives me an IRQ number of 0 which makes
sense as the IRL0 to IRL3 will all be 0 for IRL interrupt priority 15.
The SMSC91x driver fails if the irq number is 0 so I fixed this

//    if (ndev->irq <= 0) {
    if (ndev->irq < 0) {
        printk(KERN_ERR "[%s]: platform_get_irq failed %d\n",
            CARDNAME, ndev->irq);
        ret = -ENODEV;
        goto out_release_io;
    }
but I get a null pointer exception on the following line in the driver
irq_get_irq_data(ndev->irq)
so it looks like there is no IRQ desc setup for 0 and looking back in
the log I see (I've added my own debug to see what IRQ desc are being
inserted.

[    0.000000] NR_IRQS:8 nr_irqs:8 0
[    0.000000] intc: Registered controller 'sh7760' with 59 IRQs
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 32
[    0.000000] intc_register_irq 5 32
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 33
[    0.000000] intc_register_irq 6 33
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 34
[    0.000000] intc_register_irq 7 34
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 35
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 36
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 37
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 44
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 45
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 46
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 47
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 38
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 48
[    0.000000] intc_register_irq 8 48
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 49
[    0.000000] intc_register_irq 9 49
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 50
[    0.000000] intc_register_irq 10 50
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 51
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 56
[    0.000000] intc_register_irq 12 56
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 57
[    0.000000] intc_register_irq 13 57
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 58
[    0.000000] intc_register_irq 14 58
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 59
[    0.000000] intc_register_irq 15 59
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 60
[    0.000000] intc_register_irq 16 60
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 61
[    0.000000] intc_register_irq 17 61
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 62
[    0.000000] intc_register_irq 18 62
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 63
[    0.000000] intc_register_irq 19 63
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 64
[    0.000000] intc_register_irq 20 64
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 65
[    0.000000] intc_register_irq 21 65
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 68
[    0.000000] intc_register_irq 22 68
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 69
[    0.000000] intc_register_irq 23 69
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 70
[    0.000000] intc_register_irq 24 70
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 52
[    0.000000] intc_register_irq 25 52
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 53
[    0.000000] intc_register_irq 26 53
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 54
[    0.000000] intc_register_irq 27 54
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 55
[    0.000000] intc_register_irq 28 55
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 72
[    0.000000] intc_register_irq 29 72
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 73
[    0.000000] intc_register_irq 30 73
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 74
[    0.000000] intc_register_irq 31 74
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 75
[    0.000000] intc_register_irq 32 75
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 76
[    0.000000] intc_register_irq 33 76
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 77
[    0.000000] intc_register_irq 34 77
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 78
[    0.000000] intc_register_irq 35 78
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 79
[    0.000000] intc_register_irq 36 79
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 80
[    0.000000] intc_register_irq 37 80
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 81
[    0.000000] intc_register_irq 38 81
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 82
[    0.000000] intc_register_irq 39 82
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 83
[    0.000000] intc_register_irq 40 83
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 84
[    0.000000] intc_register_irq 41 84
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 88
[    0.000000] intc_register_irq 42 88
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 89
[    0.000000] intc_register_irq 43 89
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 90
[    0.000000] intc_register_irq 44 90
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 91
[    0.000000] intc_register_irq 45 91
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 100
[    0.000000] intc_register_irq 46 100
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 108
[    0.000000] intc_register_irq 47 108
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 109
[    0.000000] intc_register_irq 48 109
[    0.000000] intc_register_irq 49 16
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 17
[    0.000000] intc_register_irq 50 17
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 18
[    0.000000] intc_register_irq 51 18
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 19
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 27
[    0.000000] intc_register_irq 52 27
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 28
[    0.000000] intc_register_irq 53 28
[    0.000000] XXXXXXXXXXXXXXX: irq_insert_desc 29
[    0.000000] hiconect_sh7760_init_irq

Is there something I should be doing to get IRL level encoded
interrupts working for SH7760?  I'm using a 4.1 Kernel.

Many Thanks,
Martin.
