From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Jan 2008 10:49:36 +0000
Subject: Re: [PATCH] sh: declared coherent memory support V2
Message-Id: <20080124104936.GA26541@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 24, 2008 at 06:35:10PM +0900, Magnus Damm wrote:
> sh: declared coherent memory support V2

On Thu, Jan 24, 2008 at 06:40:50PM +0900, Magnus Damm wrote:
> sh: use declared coherent memory for dreamcast pci ethernet adapter

On Thu, Jan 24, 2008 at 06:45:45PM +0900, Magnus Damm wrote:
> sh: remove consistent alloc stuff from the machine vector

Applied, thanks.

It would be good if the Dreamcast folk(s) can ensure that there are no
regressions with the BBA with the curreng git kernel.
