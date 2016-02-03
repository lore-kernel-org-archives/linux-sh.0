From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 03 Feb 2016 07:11:11 +0000
Subject: Re: [LTSI-dev] THERMAL:Incorrect measured temperature value after unbind/bind
Message-Id: <20160203071111.GA11976@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160203041020.GA22555@kroah.com>
In-Reply-To: <20160203041020.GA22555@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 03, 2016 at 04:57:05AM +0000, Hisao Munakata wrote:
> Greg
> 
> If I am not wrong, LTSI can merge linux-next (not yet merged)
> fix unlike regular LTS release, if it is demanded by the industry.

The patch is in Linus's tree, I don't understand why you are referring
to linux-next here, it came out in 4.5-rc1.

> In this particular case, I think it is too late as LTSI-4.1 is already released.
> But I wanted to reconfirm guideline of LTSI patch adoption.
> For me linux-next code is already verified in the community and
> it is relatively clean and safe fix compared to in-house patch.
> 
> How do you think?

I think that if this is a bugfix that really is needed, then it should
probably go to the stable releases so that everyone can benifit.  Why
wouldn't it be needed there first?  Then, any LTSI user will
automatically get it when they update their base kernel version, as they
always should be doing.

thanks,

greg k-h
