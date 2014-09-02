From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 02 Sep 2014 17:28:07 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <5405FE27.4050909@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com> <20140824064520.GA2578@katana> <53F9CCE7.3010006@cogentembedded.com> <20140825034009.GA2795@katana> <53FB1F90.6080704@cogentembedded.com> <20140825143316.GA1285@katana> <5405FAD3.90403@cogentembedded.com> <20140902171835.GA10355@katana>
In-Reply-To: <20140902171835.GA10355@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On 09/02/2014 09:18 PM, Wolfram Sang wrote:

>>> As I understood from your previous mail, a plain revert is less broken
>>> but still broken. Applying a correct fix is my preferred way.

>>     Actually, from the -stable kernel perspective, a single patch would
>> complicate backporting. So could you please reconsider?

> I don't see why. If we have two patches, the state inbetween them is
> broken.

    Even so, it has always been broken, we don't make it more broken by 
reverting your change.

> And we don't have two patches yet, just the revert. So, the

    I'm going to consider the spinlock issue ASAP, after I check whether the 
I2C clock frequency really has any influence on the unexpected read NACK issue 
I've been chasing for several days.

> result is broken anyhow.

> Can you elaborate?

    Your patch removing the spinlock went into 3.16 only but we'd have to 
backport the assumed single patch to the -stable kernels older than that. This 
means that I'd have to provide the "delta" patch (i.e. the separate patch that 
I'd like to provide now atop of the revert) for these kernels instead since 
the original single patch wouldn't apply anyway.

WBR, Sergei

