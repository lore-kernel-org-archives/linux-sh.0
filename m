From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Feb 2008 04:08:29 +0000
Subject: Re: [PATCH] sh: migor board support
Message-Id: <20080207040829.GA16472@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080206153824.27144.90267.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080206153824.27144.90267.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 07, 2008 at 12:38:24AM +0900, Magnus Damm wrote:
> This patch adds basic support for the Migo-R board. 
> 
> Only simple stuff provided by the cpu specific sh7722 code is in place now,
> like serial console port, timers and usb gadget. There is also partial support
> for the smc91c111 ethernet controller - unfortunately some driver header file
> also needs patching (not included here) to make the driver get IRQ sense
> information from the platform data.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied also, thanks.
