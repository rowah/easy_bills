defmodule EasyBillsWeb.HomeLive do
  @moduledoc false

  use EasyBillsWeb, :live_view

  alias EasyBillsWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-1/2 h-screen hidden lg:block">
        <img
          src={~p"/images/section-invoice.png"}
          alt="EasyBills Image"
          class="object-cover w-full h-full"
        />
      </div>
      <div class="mx-auto mt-16 items-center justify-center mx-w-md">
        <div class="flex mb-20">
          <CoreComponents.logo_icon />
          <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
        </div>
        <h3 class="text-center font-bold text-3xl">
          Sign in to EasyBills.
        </h3>
        <div class="mt-10 grid space-y-8 mx-w-sm">
          <button
            aria-label="Continue with google"
            role="button"
            class="group h-12 px-6 border-2 border-gray-300 rounded-full transition duration-300
    hover:border-blue-400 focus:bg-blue-50 active:bg-blue-100 mx-w-sm"
          >
            <div class="relative flex items-center space-x-4 mx-w-sm justify-center">
              <svg
                width="19"
                height="20"
                viewBox="0 0 19 20"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M18.9892 10.1871C18.9892 9.36767 18.9246 8.76973 18.7847 8.14966H9.68848V11.848H15.0277C14.9201 12.767 14.3388 14.1512 13.047 15.0812L13.0289 15.205L15.905 17.4969L16.1042 17.5173C17.9342 15.7789 18.9892 13.221 18.9892 10.1871Z"
                  fill="#4285F4"
                />
                <path
                  d="M9.68813 19.9314C12.3039 19.9314 14.4999 19.0455 16.1039 17.5174L13.0467 15.0813C12.2286 15.6682 11.1306 16.0779 9.68813 16.0779C7.12612 16.0779 4.95165 14.3395 4.17651 11.9366L4.06289 11.9465L1.07231 14.3273L1.0332 14.4391C2.62638 17.6946 5.89889 19.9314 9.68813 19.9314Z"
                  fill="#34A853"
                />
                <path
                  d="M4.17667 11.9366C3.97215 11.3165 3.85378 10.6521 3.85378 9.96562C3.85378 9.27905 3.97215 8.6147 4.16591 7.99463L4.1605 7.86257L1.13246 5.44363L1.03339 5.49211C0.37677 6.84302 0 8.36005 0 9.96562C0 11.5712 0.37677 13.0881 1.03339 14.4391L4.17667 11.9366Z"
                  fill="#FBBC05"
                />
                <path
                  d="M9.68807 3.85336C11.5073 3.85336 12.7344 4.66168 13.4342 5.33718L16.1684 2.59107C14.4892 0.985496 12.3039 0 9.68807 0C5.89885 0 2.62637 2.23672 1.0332 5.49214L4.16573 7.99466C4.95162 5.59183 7.12608 3.85336 9.68807 3.85336Z"
                  fill="#EB4335"
                />
              </svg>
              <p class="text-base font-medium ml-4 text-gray-700">Continue with Google</p>
            </div>
          </button>
          <button class="group h-12 px-6 border-2 border-gray-300 rounded-full transition duration-300
    hover:border-blue-400 focus:bg-blue-50 active:bg-blue-100">
            <div class="relative flex items-center space-x-4 justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-6 h-6"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"
                />
              </svg>

              <.link
                href={~p"/login"}
                class="text-md leading-6 text-gray-700 font-semibold hover:text-zinc-700 tracking-wide"
              >
                Continue with email
              </.link>
            </div>
          </button>
          <p class="text-xs text-gray-500 px-16 md:px-6 max-w-sm leading-loose text-center">
            By creating an account, you agree to EasyBills Company's <br class="md:hidden" />
            <a href="#" class="font-bold">Terms of Use</a>
            and <a href="#" class="font-bold">Privacy Policy</a>.
          </p>
          <p class="mx-w-sm mx-auto">
            Don't have an account?
            <.link
              href={~p"/register"}
              class="text-[0.8125rem] leading-6 text-purple-500 font-semibold hover:text-zinc-700"
            >
              Sign up
            </.link>
          </p>
        </div>
      </div>
    </div>
    """
  end
end
