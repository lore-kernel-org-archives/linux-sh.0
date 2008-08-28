From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Thu, 28 Aug 2008 11:50:27 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <aec7e5c30808280450h3cb0fceaodbdb63592fe6db51@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_27443_27758416.1219924227973"
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
To: linux-sh@vger.kernel.org

------=_Part_27443_27758416.1219924227973
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Aug 28, 2008 at 12:00 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Aug 27, 2008 at 06:32:02PM +0200, Luca Santini wrote:
>> >>>+static struct smc91x_platdata smc91x_info = {
>> >>>+  .flags = SMC91X_USE_16BIT,
>> >>>+};
>> >>>+
>> >For some reason your flags here and your later smc91x patch for edosk7760
>> >have absolutely nothing in common. This leads me to believe that you
>> >either couldn't get the dynamic configuration working, in which case this
>> >bit of code is useless, or that it works fine and there's no need for the
>> >changes to smc91x.h. If you need both, you are doing something very
>> >wrong.
>> >
>>
>> you're right; what i really need is
>>
>> #define SMC_IO_SHIFT 1
>>
>> but using the platdata flag
>>
>> SMC91X_IO_SHIFT_1
>>
>> doesn't work.
>>
> Ok, so that's a real bug then. Magnus, can you take a look at this?

The io shift platform data configuration should be generic, but it
looks like it has been fully hooked in by some ARM platforms only at
this point. Someone forgot to fix the generic case. Try the attached
patch, that should get you going. Let me know if it solves your issue.

/ magnus

------=_Part_27443_27758416.1219924227973
Content-Type: application/octet-stream;
 name=linux-2.6.27-rc-smc91x-platform-data-io-shift-20080828.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkfb9fx40
Content-Disposition: attachment;
 filename=linux-2.6.27-rc-smc91x-platform-data-io-shift-20080828.patch

LS0tIDAwMDEvZHJpdmVycy9uZXQvc21jOTF4LmgKKysrIHdvcmsvZHJpdmVycy9uZXQvc21jOTF4
LmgJMjAwOC0wOC0yOCAyMDo0MzowMy4wMDAwMDAwMDAgKzA5MDAKQEAgLTQ0Niw2ICs0NDYsOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgTFBEN19TTUNfb3V0c3cgKHVuc2lnCiAjZGVmaW5lIFNNQ19D
QU5fVVNFXzMyQklUCTEKICNkZWZpbmUgU01DX05PV0FJVAkJMQogCisjZGVmaW5lIFNNQ19JT19T
SElGVAkJKGxwLT5pb19zaGlmdCkKKwogI2RlZmluZSBTTUNfaW5iKGEsIHIpCQlyZWFkYigoYSkg
KyAocikpCiAjZGVmaW5lIFNNQ19pbncoYSwgcikJCXJlYWR3KChhKSArIChyKSkKICNkZWZpbmUg
U01DX2lubChhLCByKQkJcmVhZGwoKGEpICsgKHIpKQo=
------=_Part_27443_27758416.1219924227973--
