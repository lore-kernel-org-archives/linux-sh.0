From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Oct 2009 02:12:51 +0000
Subject: Re: [PATCH] usb: r8a66597-udc unaligned fifo fix
Message-Id: <20091005021251.GB3185@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 30, 2009 at 08:57:24PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Rework the r8a66597-udc fifo code to avoid unaligned accesses.
> 
> Without this patch unaligned exceptions will degrade the
> USB performance. The exceptions come from the fact that
> the usb fifo data buffers may be misaligned.
> 
> This patch updates the fifo access code to only use
> insl()/outsl() and insw()/outsw() in the case of properly
> aligned data buffers. The fallback case is that inl()/inw()
> are used for misaligned buffer reads together with outb()
> that is used for misaligned buffer writes.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Tested on kfr2r09 with CONFIG_USB_CDC_COMPOSITE=y
> 
>  drivers/usb/gadget/r8a66597-udc.h |  105 +++++++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 43 deletions(-)
> 
Applied, thanks.
