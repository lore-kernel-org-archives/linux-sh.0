From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Mar 2015 13:55:36 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <5516B2D8.6010006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com> <55163959.8080101@gmx.de>
In-Reply-To: <55163959.8080101@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

On 3/28/2015 8:17 AM, Lino Sanfilippo wrote:

>> +	spinlock_t lock;		/* Register access lock */

> Do you really need one huge lock for all register accesses? Maybe you

    AFAIK, this is the usual practice.

> Regards,
> Lino

WBR, Sergei

