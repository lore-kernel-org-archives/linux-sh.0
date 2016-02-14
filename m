From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 14 Feb 2016 19:08:53 +0000
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Message-Id: <20160214190853.GA1522@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
List-Id: <linux-sh.vger.kernel.org>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
 <20150911104258.2563e238@endymion.delvare>
In-Reply-To: <20150911104258.2563e238@endymion.delvare>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

I think we are approaching 1 year since I submitted the first version,
so I thought it might finally be time for getting this done :)

Thank you for your careful review. All comments which I did not respond
to are silently acknowledged, same for most comments to patch 2/2. I
have implemented most of the changes already, but still need to do the
testing and the man page. However, here are already the responses to
your comments.

> I think it can be included together with the other tools. It's just as
> dangerous a tool as the other ones, not more. The fact that it can't be
> used on SMBus-only controllers even kind of makes it less dangerous.

Yes, I happily agree.

> > Tested with various Renesas I2C IP cores as well as Tegra and AT91.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Not needed for i2c-tools contributions.

Feel free to drop it. I'd still like to be clear when posting patches on
public mailing lists.

> >  tools/Module.mk     |   8 +-
> >  tools/i2ctransfer.c | 320 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >
> >  2 files changed, 327 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/i2ctransfer.c
>=20
> Where is the manual page? We need one, it's mandatory for some
> distributions. And "make install" currently fails because
> tools/i2ctransfer.8 is missing.

I wanted to check the review before doing one.

> While this is not kernel code, I would recommend that you run the
> kernel's scripts/checkpatch.pl on tools/i2ctransfer.c. Most of the
> problems reported are relevant and fixing them would improve
> readability.

Some of them are to be consistent with the rest of the I2C tools, e.g.

ERROR: trailing statements should be on next line
#136: FILE: /home/ninja/Tools/i2c-tools/tools/i2ctransfer.c:136:
+		case 'V': version =3D 1; break;

And I am not too strict on the 80 char limit. Are you?

> > +	fprintf(stderr,
> > +		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS DESC [DATA] [DESC [DA=
TA]]...\n"
> > +		"  I2CBUS is an integer or an I2C bus name\n"
> > +		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
> > +		"    1) read/write-flag 2) LENGTH (range 0-65535) 3) I2C address (us=
e last one if omitted)\n"
>=20
> Note that the I2C_RDWR ioctl interface currently limits the per-message
> length to 8192 bytes. I can't really think of a good reason for doing
> so, other than the fact that buffers larger than this may be difficult
> to allocate.

I'd guess it was introduced to prevent congestion on the bus? I am
tempted to remove it in i2c-dev and allow 65535 bytes. What do you
think?

> > +static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned fla=
gs)
> > +{
> > +	__u32 i, j;
> > +	FILE *output =3D flags & PRINT_STDERR ? stderr : stdout;
>=20
> Why don't you just pass the FILE * argument as the first parameter of
> this function?

To keep the argument list of this function small.

> > +
> > +		if (flags & PRINT_HEADER)
> > +			fprintf(output, "Msg %u: addr 0x%02x, %s, len %u",
> > +				i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
> > +		if (msgs[i].len &&
> > +		   (read =3D=3D !!(flags & PRINT_READ_BUF) ||
> > +		   !read =3D=3D !!(flags & PRINT_WRITE_BUF))) {
>=20
> Could be indented (aligned) better to improve readability. Also the
> last two statements seems needlessly complex. I'd write:
>=20
> 		if (msgs[i].len &&
> 		    (read && (flags & PRINT_READ_BUF) ||
> 		     !read && (flags & PRINT_WRITE_BUF))) {

Yes, I like. I even moved the last two lines into a seperate assignment
of a variable 'print_buf' and do now:

	if (msgs[i].len && print_buf) { ... }

>=20
> > +			if (flags & PRINT_HEADER)
> > +				fprintf(output, ", buf ");
>=20
> You'd rather drop the trailing white space...
>=20
> > +			for (j =3D 0; j < msgs[i].len; j++)
> > +				fprintf(output, "0x%02x ", msgs[i].buf[j]);
>=20
> ... and move the white space at the beginning here. This avoids printing
> a trailing space before the newline (which could cause an extra blank
> line on display if you are unlucky with the terminal width.)

I can't do that because I then I get a leading white space when
!PRINT_HEADER. I use an extra fprintf for the last byte now. That also
gave me an idea how to refactor the newline handling. All the double
negation is gone, too. Looks much better now!

> > +			newline =3D 1;
> > +		}
> > +		if (newline)
> > +			fprintf(output, "\n");
>=20
> In which case exactly would the newline not be printed? Read of length
> 0? I doubt it is worth caring about. I'd even say that printing a blank
> line in this case is preferable, so that the output really corresponds
> to what happened. Otherwise you can't tell the difference between read
> of length 0 followed by read of length 1 and the other way around.

The idea is: For !PRINT_HEADER, print only the data bytes received. Because=
 the
user crafted the transfer, I consider it known which line means what. If th=
is
is not the case, '-v' (PRINT_HEADER) should be used for debugging. With tha=
t in
mind, I don't think a newline should be printed for read messages with leng=
th
0.

> > +int main(int argc, char *argv[])
> > +{
> > +	char filename[20];
> > +	char *end;
> > +	int i2cbus, address =3D -1, file, arg_idx =3D 1, nmsgs =3D 0, nmsgs_s=
ent;
> > +	int force =3D 0, yes =3D 0, version =3D 0, verbose =3D 0;
> > +	unsigned buf_idx =3D 0;
> > +	unsigned long len, raw_data;
> > +	__u8 data;
> > +	__u8 *buf;
> > +	__u16 flags;
> > +	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
> > +	struct i2c_rdwr_ioctl_data rdwr;
> > +	enum parse_state state =3D PARSE_GET_DESC;
>=20
> That's a lot of local variables. I think some of them could be declared
> inside the state machine. Did you try moving the state machine to a
> separate function? Maybe if would improve readability.

I reduced the scope of a few variables. TBH I don't feel like putting the s=
tate
machine into a seperate function right now. It does have overhead and it fe=
els
a bit like an academic exercise to me. And I had my share of academic excer=
cise
these days with freeing the buffers (see later) ;)

> > +			len =3D strtoul(arg_ptr, &end, 0);
> > +			if (len > 65535) {
>=20
> 0xffff would be easier to understand IMHO. Also you must check that
> arg_ptr !=3D end, i.e. you managed to parse anything. Otherwise a faulty
> argument like w@0x50 will be parsed successfully (silently assuming len
> =3D 0) and odds are that the following argument won't be parsed
> successfully. In that case the error message will point the user to the
> wrong argument.

Great catch, thanks!

>=20
> > +				fprintf(stderr, "Error: Length invalid\n");
> > +				goto err_out;
> > +			}
> > +
> > +			arg_ptr =3D end;
> > +			if (*arg_ptr) {
> > +				if (*arg_ptr++ !=3D '@') {
> > +					fprintf(stderr, "Error: No '@' after length\n");
> > +			if (len) {
> > +				buf =3D malloc(len);
> > +				if (!buf) {
> > +					fprintf(stderr, "Error: No memory for buffer\n");
> > +					goto err_out;
> > +				}
> > +				memset(buf, 0, len);
> > +				msgs[nmsgs].buf =3D buf;
> > +			}
>=20
> Else msgs[nmsgs].buf should be set to NULL. Otherwise you're passing a
> random address value to the kernel.

I can't do the else branch as you suggested. If I hit an error path before =
this
if-block, the pointer is still uninitialized and the cleanup loop will try =
to
free this dangling pointer. So, I need to do it earlier which is why I had =
the
extra loop initializing all messages in the next patch. I tried clearing the
pointer at the beginning of the switch-statement. But that caused problems,
too, when nmsgs =3D=3D 0 as mentioned in the next paragraph. Then we skip t=
he
parsing while-loop and ALL pointers are dangling.

>=20
> > +
> > +	if (state !=3D PARSE_GET_DESC || nmsgs =3D=3D 0) {
>=20
> I'd be surprised if nmsgs =3D=3D 0 can actually happen. You checked that =
at
> least one parameter was left to parse on the command line before
> entering the state machine. If you couldn't parse it then it must have
> triggered some error earlier and you'll never reach this test.

It can. 'i2ctransfer 0'

Thanks,

   Wolfram


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwNDFAAoJEBQN5MwUoCm2qhoP/3KOz1yMHlz4ZkKFJ+WO9Zs9
K/h1u5zXOrSHYYeBY9Y88eeeqvufRu0L4TV+q3VVh7vZQJNEGtJiBUyPEG0xAWi/
P3/jkfedph2yFwKvTnfwh9DkYDHGRZPwZRRQBHpXZm0dH99UVfwvdofh3JQ09anz
yd7aOR2wOC+5AFWcJdM4Z2k9HIQLxpu6RU4YVInaJmISrJbonq/nCTpB3i79MQkF
dmJxfWwnocprja1gxfHI0Ms3nVjYMq6vuE2NpLDcrdzv6uE9PvCii6POulueMb7N
JP0rb048xUp9+jXsX5bIQMuM+PPBb/FzIPzcuaNr3EMHSux43avd74omykTN9116
ARA9ZgPBmVqCTBiotA6HzVLm3VPAhGBhEvs7j2UpBibEId4oXGToF1XgfyMihOaH
U0Jm9J2GfuUrXtxZeeETJlVbQIr1MqjMe6eFIXUWXtefdTlWdbAl+146+n05t3zl
CDqb1Xz8AGbk/J7nGe48u563w47/b5fhL4rFa8ZWl/2Fpgi5c/WuNppA0E9uNPKj
fAxC1nulsEX8hKcSiRrIjZaA1NkWW7ad1im72dCnnlYXUc0eAGTkHi39Es7Zclu8
G74qYpXRm41I46lKnSA+qSOnnoA5EcILxhdwx++gxEo5YHKZRKu/sRMTKD4gbj+j
dIQmV/DFjZZqP6tuM74m
=jqCk
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
