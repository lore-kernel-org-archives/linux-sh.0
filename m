From: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
Date: Mon, 21 Feb 2011 09:54:40 +0000
Subject: Re: [BUG] Serial driver broken on migor
Message-Id: <AANLkTi=xUqXm08ycZmx_pPU8VCzzDcvpF8=GVX7tEdC7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1102211046270.26977@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102211046270.26977@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> As earlier reported on IRC, commit
> 906b17dc089f7fa87e37a9cfe6ee185efc90e0da locks up migor hard without any
> output on the serial console. I haven't re-tested the very latest kernel
> versions, but I don't see any fixes being committed either.

Try applying this little patch:

http://www.spinics.net/lists/linux-sh/msg06875.html

It has not yet been pushed but has been accepted AFAIK. Alternatively,
your board should boot if you enable earlyprintk.

Alex.
