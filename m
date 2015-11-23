From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 23 Nov 2015 12:21:42 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: alt: Correct ether pfc
Message-Id: <565304D6.1070801@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
 <1448263004-14548-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448263004-14548-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 11/23/2015 10:16 AM, Simon Horman wrote:

> 0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
> pfc pins to the alt device tree but did not reference them. This patch

    Merge introduced?

> fixes ether pfc by:
>
> * Referencing ether pins
> * Adding and referencing phy1 pins
> * Removing ether b pins. These are not used in the configuration
>    of the alt board used for testing and their presence prevents
>    ethernet from functioning correctly in that environment.
>
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

MBR, Sergei

