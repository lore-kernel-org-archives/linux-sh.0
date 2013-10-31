From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 31 Oct 2013 18:03:45 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
Message-Id: <5272A98B.3030705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>	<201310310219.58963.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTa6-UP88146KPy9zNXNTRynBVqWZYb1k=0MK03NMJqhw@mail.gmail.com>
In-Reply-To: <CANqRtoTa6-UP88146KPy9zNXNTRynBVqWZYb1k=0MK03NMJqhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 10/31/2013 11:06 AM, Magnus Damm wrote:

>> Register Ether platform device and pin data on  the  Koelsch board.
>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Thanks for your patch. Just like on the Lager board we also need to
> tie in the PHY IRQ pin.

    Not only on the Lager board, BOCK-W also I think.

> Polling is not good enough when the hardware
> can do better. Can you please share your PHY IRQ plans with us?

    It's on my agenda now -- will start after I do away with the CAN driver 
and the current Koelsch Ether support.

> Best,

> / magnus

WBR, Sergei

