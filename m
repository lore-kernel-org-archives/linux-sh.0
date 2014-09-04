From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Sep 2014 07:13:58 +0000
Subject: Re: [PATCH v2 01/10] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <20140904071357.GD9999@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 02, 2014 at 11:12:57AM +0200, Ulrich Hecht wrote:
> Driver for the SH73A0's clocks that are too specific to be supported by a
> generic driver.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  31 ++++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-sh73a0.c                  | 202 +++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-sh73a0.c

Its not a big deal to me but there seems to be some precedence
for having separate patches for the driver and documenting its bindings.
