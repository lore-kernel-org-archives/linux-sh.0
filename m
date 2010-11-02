From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Nov 2010 15:53:03 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix sh7372 after a recent clock framework rework
Message-Id: <20101102155303.GF5583@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011021227560.4552@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011021227560.4552@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 02, 2010 at 12:28:33PM +0100, Guennadi Liakhovetski wrote:
> The updated sh clock framework has introduced a .nr_freqs element of struct
> clk, which has to be initialised with the number of possible frequencies.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
