From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 28 Mar 2015 08:36:00 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <20150328083600.GB4255@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com>
 <55163959.8080101@gmx.de>
In-Reply-To: <55163959.8080101@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Mar 28, 2015 at 06:17:13AM +0100, Lino Sanfilippo wrote:
> 
> Do you really need one huge lock for all register accesses? Maybe you
> should rethink which registers can actually be accessed concurrently and
> implement some finer grained locking.

One lock is fine, unless the registers are highly contended.

Thanks,
Richard
