From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 28 Nov 2009 13:10:49 +0000
Subject: Re: [PATCH] mfd: Add power control platform data to SDHI driver
Message-Id: <aec7e5c30911280510j7dedeadaha971b68b639f638e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Samuel,

On Fri, Nov 27, 2009 at 2:47 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> On Fri, Nov 27, 2009 at 01:31:27PM +0900, Magnus Damm wrote:
>> This patch adds platform data with a function for power
>> control to the SDHI driver. The idea is that board specific
>> code can provide their own functions so power can be enabled
>> and disabled for the sd-cards.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0Needed by the Ecovec board.
>> =A0Apply on top of the SDHI driver in the SuperH tree.
> I wasnt cc'ed on that driver, right ? Just checking I didnt forget it...

You are correct, my bad. I'll do my best to keep you CC:ed from now on!

/ magnus
