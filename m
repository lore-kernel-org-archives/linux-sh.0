From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 14 Jun 2011 12:15:10 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Mackerel USB platform data update
Message-Id: <BANLkTimtsNNQeLKxuNrVtgzQAmEZHKhurg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609070337.3122.1679.sendpatchset@t400s>
In-Reply-To: <20110609070337.3122.1679.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 14, 2011 at 5:36 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Jun 14, 2011 at 04:54:04PM +0900, Magnus Damm wrote:
>> On Tue, Jun 14, 2011 at 3:31 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Thu, Jun 09, 2011 at 05:44:21PM +0900, Magnus Damm wrote:
>> >> On Thu, Jun 9, 2011 at 4:09 PM, Kuninori Morimoto
>> >> <kuninori.morimoto.gx@renesas.com> wrote:
>> >> > I think AP4 USB0 pipe9 is interrupt.
>> >> > If so, this pipe config is not needed.
>> >> > it is same as renesas_usbhs default pipe configs.
>> >> > see
>> >> > ?renesas_usbhs/common.c :: usbhs_default_pipe_type
>> >>
>> >> Ok, thanks, can you please send an incremental patch to fix this?
>> >>
>> > I've grudgingly applied this patch as it is, but I really don't like this
>> > half-assed approach to patch submission. The onus is not on Morimoto-san
>> > to fix up your submission when he's pointed out something that you
>> > obviously failed to take under consideration on an initial patch. You
>> > should have simply discarded this and submitted an updated version that
>> > fixed this up, and in a timely fashion.
>>
>> Thanks for picking up the patch. Under normal circumstances I would
>> agree that me sending a new version would be the best way forward, but
>> this case is somewhat different. I didn't send a V2 because:
>> a) I expected Morimoto-san to help me
>> b) I wasn't sure if his comment was correct
>>
>> The background of all this is that I asked Morimoto-san for help with
>> USB platform data. When then got submitted to the mailing list only
>> _one_ of the USB ports were supported, and when I tried to encourage
>> people to add support for both ports i received the reply that this
>> was "impossible". So I decided to fix it myself. Believe it or not, I
>> expect both USB ports on my board to work.
>>
> Ok, it would have been nice to know that in advance, then I would have
> been much less grumpy. Since there seems to be some uncertainty with
> regards to the pipe9 bulk vs interrupt setting I suppose all we can do
> now is go with your version until it's demonstrably shown to be
> incorrect (which works out well, since that's the version I merged).

I've done some checking about USBHS0 pipe configuration and
Morimoto-san seems correct. Will submit an incremental patch.

>> > Since none of these things have happened and it's unlikely that any of
>> > them will before some -next time leading up to the next -rc I've taken it
>> > verbatim, but am certainly not happy with having had to do so, nor do I
>> > see much reason to continue to do so in the future.
>>
>> I don't expect you to do so, but if you are unsure about any schedule
>> feel free to ask over mail or in person.
>>
> Usually we have a -rc every week, and I like to have things sitting in
> -next for at least a couple of days before I send them out to Linus. This
> sort of stuff is unlikely to introduce any regression in other areas
> outside of the configuration that you're already testing, but we've
> certainly been bitten by enough seemingly obvious and "tested" stuff in
> the past that we really do need the padding. With something this big and
> insular it's possible to be a bit more flexible, but generally things of
> this size I expect around -rc2 at the latest.

Sounds good, I think your expectations are very reasonable.

> The first I even found out that there was a driver was after the USB
> merge during the merge window. This is normally ok, but we could easily
> have coordinated this better, had the driver in a topic branch pulled in
> from the USB tree (or pulled by the USB tree) with the platform data on
> top so it all has enough time to be tested together and improved upon,
> and ultimately all ready to go immediately once the merge dependencies
> are taken care of.

I believe I've asked to get the platform data submitted way before the
merge window, but I may have been a bit unclear.

> Generally I don't mind adding platform data bits later in the -rc
> timeframe, but in this particular case it's obvious that everyone would
> have benefitted from having this out there much earlier, and with
> increased visibility (I'm not singling you out for this, it's just a
> general observation).

Sure, but the earlier the better, I totally agree.

Thanks,

/ magnus
