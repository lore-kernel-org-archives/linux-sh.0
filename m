From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 26 May 2010 07:14:53 +0000
Subject: Re: LCDC of 7203
Message-Id: <20100526071453.GC26696@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 26, 2010 at 02:20:05AM -0400, Magnus Damm wrote:
> On Mon, May 24, 2010 at 1:12 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi all,
> > I have a little problem with LCDC of sh2a 7203.
> > I seem not to see the driver into the last kernel.
> > Where could I find a good reference?
> 
> I don't think there is any upstream 7203 LCDC driver. It's a shame, I
> really wish people would submit their code upstream.
> 
I don't remember the details specifically, I thought the issue was panel
control via MSIOF and so on, which isn't too different from G3EVM?

The existing "drivers" are much like the early G3EVM LCD support, so
while references are readily available, there's little that is directly
usable without some serious work on the infrastructure side. Perhaps we
can reuse parts of the SH-Mobile LCD support?
