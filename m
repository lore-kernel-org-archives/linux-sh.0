From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jul 2008 22:48:56 +0000
Subject: Re: [PATCH] sh_keysc: Remove request_mem_region() and release_mem_region()
Message-Id: <20080718224856.GB19263@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718083836.29015.8503.sendpatchset@localhost.localdomain> <aec7e5c30807180455o75108dc2gb7a22b95d18d251@mail.gmail.com>
In-Reply-To: <aec7e5c30807180455o75108dc2gb7a22b95d18d251@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Tetsuya Mukawa <mukawa@igel.co.jp>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org

On Fri, Jul 18, 2008 at 08:55:04PM +0900, Magnus Damm wrote:
> On Fri, Jul 18, 2008 at 5:38 PM, Tetsuya Mukawa <mukawa@igel.co.jp> wrote:
> > Remove request_mem_region() and release_mem_region() from sh_keysc driver.
> > Those functions can find resource conflict, but it is already checked in
> > platform_device_add().
> 
> Yes, the request_mem_region() and release_mem_region() calls are redundant.
> 
> > Signed-off-by: Tetsuya Mukawa <mukawa@igel.co.jp>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> Thanks for the patch! =)
> 
Applied, thanks.
