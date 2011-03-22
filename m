From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Mar 2011 16:13:49 +0000
Subject: Re: sh2a 7203 LCDC memory access
Message-Id: <20110322161349.GA8084@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201103220853.19384.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201103220853.19384.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 22, 2011 at 05:02:02PM +0100, Fabio Giovagnini wrote:
> No, Paul
> I do not expect this.
> I only ask if any of the list had problem like mine.
> Furthermore on the list there are many @renesas.com address.
> They should be the GURU's like you and I expect that being payed by renesas 
> are interested to help renesas customer (like me) to use better renesas 
> products.
> If I'm wrong tell me.
> 
This is not a sales, marketing, or customer support venue. There are many
SH-2A CPUs with different feature sets, if you are looking for something
in particular then you have appropriate channels for searching for parts
that meet your requirements as well as people that can assist you with
remedial problems.

You have the same documentation to work with as the rest of us, so unless
you're working on a prototype or unreleased CPU there's unlikely to be
anything anyone can tell you that isn't documented in public
specifications. Also keep in mind that we are talking about hundreds of
different CPUs, while I can keep track of some of the differences on
quite a number of them, I certainly couldn't tell you off the top of my
head what CPU subtype has DMA auto-request modes for the LCDC block
without looking at the same manuals you have.

At the end of the day this is a technical forum. If you have general
questions about given products or are looking for support outside of a
technical kernel development level you have a number of venues open to
you, including http://oss.renesas.com and whoever you locally source your
components from.
