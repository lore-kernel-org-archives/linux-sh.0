From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Thu, 20 Nov 2008 17:18:20 +0000
Subject: Re: Mutex fast-path implementation sh4a
Message-Id: <3650.82035.qm@web23501.mail.ird.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49241338.1010405@yahoo.it>
In-Reply-To: <49241338.1010405@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



Hi,
...

> When you are implementing this, you should also include the comment from
> ARM, as the single-pass atomic sequence without looping semantics aren't
> entirely obvious without it.
> 

I change the comment in the pathes that I already send.

> > The retval function is very quite similar to this one. I don't find 
> > documentation about sh assembler,
> > can someone point me out to documentation?
> 
> What sort of documentation are you looking for? A good start is the SH-4A

I have downloaded that one, thanks.

> software manual, which you can find the pdf for from any SH-4A part
> specification download. If you are particularly concerned about inline
> assembly, then you need to look at the GCC manual for SH-specific
> information. Anything else you can feel free to ask on the list.

I don't find it, but I will take a look at google.

Regards Michael


      Unisciti alla community di Io fotografo e video, il nuovo corso di fotografia di Gazzetta dello sport:
http://www.flickr.com/groups/iofotografoevideo
