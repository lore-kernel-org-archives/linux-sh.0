From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 10:58:46 +0000
Subject: Re: [PATCH] sh: rsk7203 CONFIG_MTD=n fix
Message-Id: <20091026105846.GA7611@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 07:08:55PM +0900, Magnus Damm wrote:
> Fix the rsk7203 board code to build with CONFIG_MTD=n.

On Mon, Oct 26, 2009 at 07:12:39PM +0900, Magnus Damm wrote:
> Add an uImage.bin target to allow uncompressed uImages.
> Useful for boards with busted u-boot decompression like
> the rsk7203 on my desk.

Applied to the 2.6.32 queue, thanks.
