From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Mon, 31 Dec 2007 16:02:10 +0000
Subject: Re: Getting the AICA device to work properly
Message-Id: <8b67d60712310802i7996bb2co45b948f5e8263603@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60712310755u6536e666gfca525bdb52df1e3@mail.gmail.com>
In-Reply-To: <8b67d60712310755u6536e666gfca525bdb52df1e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

On 31/12/2007, Adrian McMenamin <lkmladrian@gmail.com> wrote:

> When I use the emulation layer now (rebuilding mpg123) I now get:
>
> $ mpg123 ./ms.mp3
> [getlopt.c:115] debug: getsingleopt: ./ms.mp3
> [audio.c:501] debug: opening normal audio/file
> [oss.c:180] error: Can't open default sound device!
> [audio.c:505] error: failed to open audio device
> [mpg123.c:666] error: Failed to initialize output, goodbye.
>

OK, this was clearly stupid, as I hadn't loaded the emulation module!

But it still fails:

MPEG 1.0 layer III, VBR, 44100 Hz joint-stereo
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 1 at 0x12eb
[parse.c:691] debug: Frame 1 fffb1064 100, next filepos=0x1353
[libmpg123.c:436] debug: read of frame 1 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 2 at 0x1353
[parse.c:691] debug: Frame 2 fffb1064 100, next filepos=0x13bb
[libmpg123.c:436] debug: read of frame 2 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 3 at 0x13bb
[parse.c:691] debug: Frame 3 fffb1064 100, next filepos=0x1423
[libmpg123.c:436] debug: read of frame 3 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 4 at 0x1423
[parse.c:691] debug: Frame 4 fffb1064 100, next filepos=0x148b
[libmpg123.c:436] debug: read of frame 4 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 5 at 0x148b
[parse.c:691] debug: Frame 5 fffb1064 100, next filepos=0x14f3
[libmpg123.c:436] debug: read of frame 5 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 6 at 0x14f3
[parse.c:691] debug: Frame 6 fffb1064 100, next filepos=0x155b
[libmpg123.c:436] debug: read of frame 6 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 7 at 0x155b
[parse.c:691] debug: Frame 7 fffb1064 100, next filepos=0x15c3
[libmpg123.c:436] debug: read of frame 7 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 8 at 0x15c3
[parse.c:691] debug: Frame 8 fffb1064 100, next filepos=0x162b
[libmpg123.c:436] debug: read of frame 8 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 9 at 0x162b
[parse.c:691] debug: Frame 9 fffb1064 100, next filepos=0x1693
[libmpg123.c:436] debug: read of frame 9 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:517] debug: play_frame
[libmpg123.c:433] debug: read frame
[parse.c:429] debug: trying to get frame 10 at 0x1693
[parse.c:691] debug: Frame 10 fffb1064 100, next filepos=0x16fb
[libmpg123.c:436] debug: read of frame 10 returned 1 (to_decode=1)
[libmpg123.c:533] debug: got next frame, 1
[libmpg123.c:517] debug: decoding
[mpg123.c:533] error: Deep trouble! Cannot flush to my output anymore!
[audio.c:441] debug: exit output
[audio.c:524] debug: closing output
[audio.c:148] debug: closing output module
