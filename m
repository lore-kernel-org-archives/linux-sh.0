From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 05 Mar 2013 13:42:31 +0000
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Message-Id: <5135F647.8050002@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
 <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
 <2835497.S76YK1KMLM@wuerfel>
 <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
In-Reply-To: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05-03-2013 17:00, Bastian Hecht wrote:

>>> +       sci@e6c40000 {
>>> +               compatible = "renesas,sci-SCIFA-uart";
>>> +               interrupt-parent = <&intca>;
>>> +               reg = <0xe6c40000 0x100>;
>>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>>> +               cell-index = <0>;
>>> +               renesas,scscr = <0x30>;
>>> +               renesas,scbrr-algo-id = <4>;
>>> +               renesas,autoconf;
>>> +       };
>>
>> The default name for a uart is "serial", I would recommend sticking to
>> that by convention. You may also want to add an "aliases" node
>> somewhere, to define which port should get which logical device number
>> on a given board.

> Switched to "...-serial".

    I think he was talking about the node name, not "compatible" property.

WBR, Sergei

