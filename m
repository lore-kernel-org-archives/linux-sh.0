From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Jul 2008 09:02:02 +0000
Subject: Re: Search for SH4 pipeline good description
Message-Id: <20080715090202.GB23440@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0807110116t7df8b3d2i7bd5afe08f5b87e4@mail.gmail.com>
In-Reply-To: <38b2ab8a0807110116t7df8b3d2i7bd5afe08f5b87e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 11, 2008 at 10:16:27AM +0200, Francis Moreau wrote:
> I'm struggling to understand how memcpy-sh4.S works and the reason is probably
> my lack of understanding of the pipeline and which instructions can be executed
> while a cache line is loaded.
> 
> I already read "sh4 core architecture manual" but I find it really bad.
> 
> Could anybody point me a good doc about this ?
> 
Read the SH-4 or SH-4A software manual, there is a detailed chapter on
pipelining. The ST parts don't do anything too profoundly different in
terms of pipelining anyways.

http://documentation.renesas.com/eng/products/mpumcu/rej09b0003_sh4a.pdf
