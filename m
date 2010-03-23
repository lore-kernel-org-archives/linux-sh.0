From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:07:32 +0000
Subject: Re: smc9118 problem
Message-Id: <20100323040732.GC13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201003222019.48247.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003222019.48247.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 22, 2010 at 08:19:48PM +0100, Fabio Giovagnini wrote:
> Hi all, II have a problem with smc9118 chip;
> I do not make any eeprom initialitazione because I do not have any eeprom on 
> my board.
> When occurs an rx overrun the chip stops to receive, and I have experienced 
> that doing 
> ~> cat /proc/smc911x/resetphy
> ~> cat /proc/smc911x/resetsmc
> ~> cat /proc/smc911x/enable
> 
> it restart properly.
> 
> I'm using kernel 2.6.17; does any of you have suggetion about I nedd to check 
> for discover which bits I have to set in case of rx overrun?
> 
Please verify whether you can reproduce this with 2.6.34-rc2, thanks.
