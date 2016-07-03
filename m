From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 11:35:17 +0000
Subject: Re: [PATCH v4 21/22] sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) IRQCHIP Driver
Message-Id: <87vb0nrm2y.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-22-git-send-email-ysato@users.sourceforge.jp>
	<20160701015313.GA31508@rob-hp-laptop>
In-Reply-To: <20160701015313.GA31508@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 01 Jul 2016 10:53:13 +0900,
Rob Herring wrote:
> 
> On Wed, Jun 29, 2016 at 10:41:06PM +0900, Yoshinori Sato wrote:
> > Changes v4
> > - split patch.
> > - remove unneeded #address
> 
> Actually, I think #address-cells is supposed to be set for 
> interrupt-map. It defines the size of the first field.

OK. reverted it.
Thanks.

> Rob

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
