From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Apr 2013 00:55:38 +0000
Subject: Re: [PATCH] irqchip: irqc: Add runtime PM support
Message-Id: <CANqRtoRBX6tmickt5bApnMc+dhtL27GCMojmh52jfY3P8tPx2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365056466-23710-1-git-send-email-horms+renesas@verge.net.au>
 <20130405022623.GD29203@verge.net.au>
In-Reply-To: <20130405022623.GD29203@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Fri, Apr 5, 2013 at 11:26 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 04, 2013 at 03:21:06PM +0900, Simon Horman wrote:
>> This was tested using the SMSC LAN on the APE6EVM board.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Magnus, Morimoto-san, could you review this?

Thanks for working on Runtime PM for the IRQC driver, this code looks
fine to me. In the future we probably want to try control the usage
count based on enable()/disable() callbacks in a more fine grained
fashion, but I wonder how much that would actually help us since I
don't think we can turn off the power domain where IRQC is located
anyway.

Simon, please remember to also merge your code for IRQC MSTP bit
control on r8a73a4 and/or r8a7790. Without that I can't really see how
Runtime PM can control any actual hardware.

Thanks,

/ magnus
