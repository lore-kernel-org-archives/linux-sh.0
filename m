From: Rob Herring <robh@kernel.org>
Date: Fri, 01 Jul 2016 01:53:13 +0000
Subject: Re: [PATCH v4 21/22] sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) IRQCHIP Driver
Message-Id: <20160701015313.GA31508@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
 <1467207667-15768-22-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-22-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 29, 2016 at 10:41:06PM +0900, Yoshinori Sato wrote:
> Changes v4
> - split patch.
> - remove unneeded #address

Actually, I think #address-cells is supposed to be set for 
interrupt-map. It defines the size of the first field.

Rob
