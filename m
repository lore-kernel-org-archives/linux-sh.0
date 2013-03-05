From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 05 Mar 2013 13:00:41 +0000
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Message-Id: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
 <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
 <2835497.S76YK1KMLM@wuerfel>
In-Reply-To: <2835497.S76YK1KMLM@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

2013/3/4 Arnd Bergmann <arnd@arndb.de>:
> On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
>>
>> +       sci@e6c40000 {
>> +               compatible = "renesas,sci-SCIFA-uart";
>> +               interrupt-parent = <&intca>;
>> +               reg = <0xe6c40000 0x100>;
>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>> +               cell-index = <0>;
>> +               renesas,scscr = <0x30>;
>> +               renesas,scbrr-algo-id = <4>;
>> +               renesas,autoconf;
>> +       };
>
> The default name for a uart is "serial", I would recommend sticking to
> that by convention. You may also want to add an "aliases" node
> somewhere, to define which port should get which logical device number
> on a given board.

Switched to "...-serial".
About the aliases: Would I need to add that now, or can we postpone that?

Thanks,

 Bastian


>         Arnd
