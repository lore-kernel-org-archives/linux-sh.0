From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Nov 2010 07:42:21 +0000
Subject: Re: [PATCH 2/5] ARM: mach-shmobile: mackerel: Add SMSC support
Message-Id: <AANLkTiku_Wm==+umBg_nNFVxQXLRTQi=h5ZFketFtDJk@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Nov 29, 2010 at 3:16 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Thank you for your check
>
>> There is no EEPROM on this board? I guess so since you use
>> SMSC911X_SAVE_MAC_ADDRESS.
>>
>> I suspect that this code is not going to work with romImage since it
>> depends on the boot loader for mac address.
>
> Yes. mackerel doesn't have EEPROM for SMSC

Is it possible that we can extend the kernel to located the MAC address som=
ehow?

>> > + =A0 =A0 =A0 gpio_request(GPIO_FN_CS5A, =A0 =A0 =A0NULL);
>> > + =A0 =A0 =A0 gpio_request(GPIO_FN_IRQ6_39, =A0 NULL);
>> > +
>>
>> If you have time, please add code to setup optimized memory
>> read/writing timings for the CS memory window here.
>
> sorry.
> What does this "optimized timings" mean ?

The memory window signal timing values associated with the CS signal
can be programmed using the BSC. The timings should be optimized so we
get decent performance. On some boards we got transmission/reception
errors with the slowest settings, and usually the U-boot settings are
far from optimal.

Also, if we use romImage we need to setup the BSC settings for the CS
signal anyway.

Look at these two linux-2.6 git commits as examples:

a30c89ad41099f58922e0941e346e7c4371655b9
724cfb944007b7f8d346523a7810b53a35921bc5

Please check to see if you can optimize the throughput.

Thanks,

/ magnus
