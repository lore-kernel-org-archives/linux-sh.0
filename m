From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 27 Dec 2013 11:38:10 +0000
Subject: Re: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
Message-Id: <52BD66A2.4050504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
 <20131227021227.GC9184@verge.net.au>
In-Reply-To: <20131227021227.GC9184@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 27-12-2013 6:12, Simon Horman wrote:

>> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
>> trigger type to be low-level as per the Micrel PHY driver's setup.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Hi Sergei,

> does this depend on changes that have been queued up in net or net-next
> since v3.13-rc1?

    Yes, in net-next.

> If so are they present in v3.13-rc5?

    No, they should be available in 3.14-rc1.

> If not please
> repost when an rc release with the required dependencies is available.

    You mean this patch should inevitably wait for 3.15? I hoped either you or 
DaveM could still queue this patch for 3.14...

WBR, Sergei

