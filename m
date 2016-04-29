From: Rob Landley <rlandley@se-instruments.com>
Date: Fri, 29 Apr 2016 04:53:35 +0000
Subject: Re: [PATCH 1/7] sh: add support for J-Core J2 processor
Message-Id: <5722E8CF.40308@se-instruments.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
In-Reply-To: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/28/2016 07:36 PM, Rich Felker wrote:
> On Thu, Apr 28, 2016 at 07:12:19PM -0500, Rob Landley wrote:
>> On 03/17/2016 06:09 PM, Rich Felker wrote:
>>> Signed-off-by: Rich Felker <dalias@libc.org>
>>
>> This came through dated March 17, and thunderbird "the dumbest mail
>> client ever, except all the other ones" doesn't let me _not_ sort my
>> mailboxes anymore, so the closest I can get is sorting by date.
>>
>> Translation: this stuff got bured way back in the history and I had to
>> open the mbox file in vi just to confirm that it was a recent post and
>> not historical.
>>
>> I take it your new "git format-patch | formail" workflow has a downside? :)
> 
> Sorry about that. The same should happen with git send-email though,
> no? Sorry I'm not used to the tools for sending patch series as mail
> threads rather than attachments. I can strip Date headers in the
> future and let them get regenerated, but a good MUA should sort by
> date received, not the sender's date headers.
> 
> Rich

I believe we've established that thunderbird is not a good MUA. (Oh,
have we established it.)

But what I determined experimentally a few years back is that the
alternatives on Linux are worse. (Unless I want something text mode that
can't pop up multiple reply windows and let me keep reading messages
while composing multiple replies in parallel, require me to save
attachments to the filesystem rather than "open this attachment
soffice/pdfviewer", don't have the _option_ of viewing html email...
Text mode mail clients we've got.)

And there's kmail bundled with kde; there used to be a very nice email
program glued to 12 different unrelated things like an rss reader and
uucp news reader and so on (tabbed interface, you stopped being able to
launch _just_ the email program many years ago. (Of course if I was
willing to submit to pressure from bundling, I'd be running windows...)
And of course when KDE 4.0 happened and I stopped being willing to put
up with KDE itself, konqueror and kmail were both glued to that
framework so I had to stop using them at all. (And no, I am NEVER going
back, period.)

So yeah: thunderbird. It sucks. Next question?

Rob

(Yes, I tried balsa. Yes I tried claws mail. Yes I tried writing my own
email handling stuff in python, but seriously, I'm busy with
_other_things_...)
