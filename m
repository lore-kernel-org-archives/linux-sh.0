From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Feb 2008 09:48:12 +0000
Subject: Re: [PATCH] SH/Dreamcast - improve detection of attached peripherals
Message-Id: <20080212094812.GA3265@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202689502.6237.23.camel@localhost.localdomain>
In-Reply-To: <1202689502.6237.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 12, 2008 at 10:36:12AM +0100, Kristoffer Ericson wrote:
> On Tue, 12 Feb 2008 17:24:25 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > Also, no attachments or MIME damage of any sort. If you aren't sure
> > whether your mailer will mangle the inline patch or not, send it to
> > yourself until you have it working.
> 
> I wasn't aware my attachments was being mangled in anyway, I'll test on 
> myself until I got it sorted.
> 
My point is that you should not be attaching patches in the first place.
The only reason people have for sending patches as attachments is because
the inline patch gets mangled. There is never a valid reason for sending
a patch as an attachment to the mailing list, it's just a lot more
tedious to deal with. Unfortunately there are valid reasons for sending
an attachment to the list, so we can't just have messages with
attachments auto-discarded, which would be preferable otherwise.

text/plain attachments can occasionally be tolerated, but most mailers
tend to use some ridiculous mime type for patches, which means one has to
mangle the type back to something sensible before it can be worked with
anyways, which is also quite irritating.

Logs and .configs and things of that nature can be attached just fine,
since they're not fed through scripts as the patches are, and rarely need
to be replied to in-line.
