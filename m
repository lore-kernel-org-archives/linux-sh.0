From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 09 Feb 2010 09:39:54 +0000
Subject: Re: [PATCH] input: bitmap update for sh_keysc V2
Message-Id: <20100209093954.GC12642@core.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 06:16:09PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the sh_keysc driver with proper bitmap support V2.
> This instead of using a fixed 32-bit integer to keep track
> for the key states. With this change in place the driver
> supports key pads with more than 32 keys.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Changes since V1:
>  - ditched the wrapping macros
>  - use __set_bit() and __clear_bit()

Thank you for making the change. It indeed is easier to read than the
original since one does not have to go and look up what wrappers are
doing.

-- 
Dmitry
